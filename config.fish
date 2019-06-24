eval (python -m virtualfish)

function avro-tools
    java -jar ~/Workspace/jars/avro-tools-1.8.2.jar $argv
end

function gprune
    git branch --merged | egrep -v "(^\*|master|dev|develop|production)" | xargs git branch -d
end
