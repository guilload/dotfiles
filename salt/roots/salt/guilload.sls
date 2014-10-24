guilload:
  user.present:
    - fullname: Adrien Guillo
    - shell: /bin/zsh
    - home: /home/guilload

sudoer:
  file.append:
    - name: /etc/sudoers
    - text:
      - "guilload ALL=(ALL) NOPASSWD: ALL"

privatekey:
  file.managed:
    - name: /home/guilload/.ssh/id_rsa
    - user: guilload
    - group: guilload
    - mode: 600
    - source: salt://sources/id_rsa
    - require:
      - user: guilload

pubkey:
  ssh_auth:
    - present
    - user: guilload
    - source: salt://sources/id_rsa.pub
    - require:
      - user: guilload

oh-my-zsh:
  cmd.run:
    - name: curl -L http://install.ohmyz.sh | sh
    - unless: test -e .oh-my-zsh
    - user: guilload
    - require:
      - pkg: zsh
      - user: guilload

github.com:
  ssh_known_hosts:
    - present
    - user: guilload
    - fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48
    - require:
      - user: guilload

git@github.com:guilload/guilload.git:
  git.latest:
    - rev: master
    - target: /home/guilload/Workspace/repositories/guilload
    - user: guilload
    - require:
      - pkg: git
      - ssh_known_hosts: github.com
      - user: guilload

{% for file in ('gitconfig', 'gitignore', 'vimrc', 'zshrc') %}

/home/guilload/.{{ file }}:
  file.symlink:
    - target: /home/guilload/Workspace/repositories/guilload/{{ file }}
    - force: true
    - user: guilload
    - require:
      - git: git@github.com:guilload/guilload.git
      - user: guilload

{% endfor %}
