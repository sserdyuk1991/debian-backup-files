# Aliases for pushd and popd
alias pd='pushd'
alias pp='popd'

# Alias for ps
alias psgrp='ps aux | grep'

# Alias for ping
alias pingg='ping google.com'

# Alias for incron table backup
alias backup-incrontab='backup-one.sh /var/spool/incron/serhiy'

# Aliases for opening frequently requested files
# Alias for opening ~/.bash_aliases file
alias aliases='vim ~/.bash_aliases'

# Some aliases for configuring scripts opening
alias install-software-list='vim ~/Dropbox/configuring/debian/after-install/auxiliary-scripts/install-software.sh'
alias uninstall-software-list='vim ~/Dropbox/configuring/debian/after-install/auxiliary-scripts/uninstall-software.sh'

# Alias for list of usefull commands
alias commands='vim ~/Dropbox/commands.txt'

# Code style aliases
alias cstyle='vim ~/Dropbox/cstyle'
alias cppstyle='vim ~/Dropbox/cppstyle'

# Some other aliases
alias todo='vim ~/Dropbox/todo.txt'
alias known_issues='vim ~/Dropbox/work/known_issues.txt'
alias tasks_planning='vim ~/Dropbox/work/tasks_planning.txt'
alias questions='vim ~/Dropbox/work/work_questions.txt'

# Aliases for find
alias findroot='sudo find / -name'
alias findhere='find . -name'

# Aliases for ranger
alias rg='ranger'
