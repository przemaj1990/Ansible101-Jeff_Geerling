- shaban
#!/bin/sh

- use lower case in variabke:
var='/tmp/'
echo $var

- shaban that get mroe detail
#!/bin/sh - v 

- shaban that print variable value
#!/bin/sh - x

- Use double quouts "$x"

- Use braces to tell where name of variable ends:
echo "${x}txt"

- Use -- as end of option like:
grep -- "$var" 

How to export variable into shell:
variable1=21
export variable1
then you can use $variable1
- in script you can use:
export var2="$variable1"
------------------
My work:
- Simple loop:
#!/bin/bash
while true; do 
    echo "Hello World" # Substitute this line for whatever command you want.
    sleep 100
done

- Loop with restriction:
#!/bin/bash
x=1
while [ $x -le 5 ]
do
  echo "Welcome $x times"
  x=$(( $x + 1 ))   <- use (( allow to use arithmetic
done

https://www.cyberciti.biz/faq/shell-script-while-loop-examples/ <- examples


------------------
Mastering Bash and Z Shell Scripting Syntax
https://app.pluralsight.com/library/courses/mastering-bash-z-shell-scripting-syntax/table-of-contents

sudo apt install zsh <- to install zsh


1. Variable (local, enviromet, command):
    export VARIABLE=1
    env | grep VARIABLE
    set | grep VARIABLE
command variable:
    $ editor=vim crontab -e (set up var before run command, so variable will only affect this command)
    $ export MYENV=utah
    $ env | grep MYENV
    $ unset VARIABLE <- clear variable
    $ VARIABLE=1 !! 
    $ 
shell build-in - declare
    declare -p VARIABLE MYENV
    declare -l (lowercase)
    declare -- VARIABLE=value
        -- <- tell that this is local vairable
    declare -x VARIABLE <- export var
    declare -p VARIABLE <- print out
    declare -r VARIABLE=value <- setup constant variable that cannot be change
    Arrays - multivalue index, 
      declare -a user_name
      user_name[0]=bob ; user_name[1]=smith
      echo ${user_name[0]}
       echo $user_name
      echo ${user_name[@]}
      echo ${user_name[0]}
      unset user_name
      declare -A user_name
      user_name[name]=bob ; user_name[lastname]=smith
      echo ${user_name[name]}

      declare -i days=30 <- i make to accept only numbers
Condition statment:
 -   AND / OR:
    echo hello || echo by (OR - one must sucess)
    echo hello && echo by (AND - both must sucess)
    if [ $days -lt 1] ;then echo 'Enter correct value'; fi
    fi - end if statment
    if [ $days -lt 1 ] || [ $days -gt 30 ] ;then echo 'Enter correct value'; fi
    if (( days <1 || days > 30 )); then echo 'costam'; fi <- arithmetic evaluation
 -  ELSE:
    if (( days <1 || days > 30 )); then echo 'costam'; else echo 'costam2'; fi
 -  ELIF:
    read variable
    if (( days < 1 )); then echo 'costam1';
    elif (( days > 30 )); then echo 'costam2';
    else echo 'costam'; 
    fi
 -  Examples:
    getent passwd user1
    getent passwd user1 || sudo useradd user1 <- if first command not success use second one
    getent passwd user1 && sudo passwd user1 <- if first sucess use second one also
    ---
    declare -i days
    read days
    30
    if [ $days -lt 1 ] ; then echo 'enter correct' ; fi
    read days
    Monday  
    if (( days <1 || days > 30 )) ; then echo 'enter correct' ; fi <- after this we will see 'enter correct' becouse we used Monday
    ---
    if (( days < 1 )) ; then echo 'enter nr value' ; elif (( days > 30 )) ; then echo ' enter calue less than 31' ; else echo 'days are $days' ; fi
 -  testing string & regex:
    declare -l user_name
    read user_name
    Bob
    [ $user_name == 'bob'] && echo 'user is bob'
    - usage of '==' diference statment from assigment of value like username=bob
    declare -l browser
    read rowser
    Firefox
    [[ $browsers == *fox ]] && echo 'the browsers is firefox'
    declare -l test_var
    read test_var
    color
    [[ $browsers =~ colou?r ]] && echo '${BASH_REMATCH[0]}' <- ?- make 'u' optional, 
    declare -l user_name
    read user_name
    Bob
    [ $user_name == 'bob' ] 
    echo $?
    [ $user_name != 'bob' ] 
    echo $?
    declare -l user_name
    read user_name
    Bob_admin
    [[ $user_name == *_admin ]]
    echo $? <- allow to read special variable
    unset user_name
    declare -l user_name
    read user_name
    Bob_admin
    declare -p user_name="Bob_admin"
    [[ $username =~ _admin$ ]] < '=~' - mean match, '_admin$' - mean end od string
    declare -ar BASH_REMATCH=()
 -  test command    
    type test [ [[
        test is a shell builtin
        [ is a shell built in
        [[ is a shell keyword
    so we can use both below options:
        test -f /etc/hosts && echo YES
        [[ -f /etc/hosts ]] && YES
    - d for directory
    - L simboliclink
    - e exisiting file
    - r/w/x for exisiting specific permission
    example:
    #!/bin/bash
    dclare -l DIR
    echo -n "costam"
    read DIR
    if [[ -e $DIR ]]
        then
            echo 'dir exist'
            exit 1
        else
            if [[ -w $PWD ]]
            then
                mkdir $DIR
            else
                echo 'costam2'
                exit 2
            fi
    fi
 - Case statment
    case $USER in <- case is imore efficient than many elif, ex:
    caee $USER in
        tux )
            echo '1'
            ;;
        root | admin )  <- we use | as or 
            echo '2'
            ;;
    esac
    
 - Effective function:
     -  function are nameade elemts that can encapsulated modular block of code, ex:
        $ function say_hello () {
         echo 'hello'
        }
        say_hello - to call function
        declare -f <- print details of functions
        declare -F <- print function names
        declare -f say_hello <- will print function definition of specific function
     -  export function:
        declare -xf say_hello 
     -  passing arguments:
        $1 - first arguments

     -  return value:
            0 - sucess
            1 or mroe - some error
        ex: return 0;

# BEST PRACTICES:
    - function shoule be stand alone - so depend on other element like variable from master script
    - use local vairable: local age=$1 <- to not affect enviroment!

 - Loops:
     -  While/Untill
        while (( x > )) ; do
            echo $x
        done
        until (( x == 0 )) ;  do
            echo $x
        done
     -  For (mostly for list)
        C-style loop:
        for (( i=0 ; i<5 ; i++ )) ; do <- (i=8 is initialize variable, i<5 is first condition, i++ is incrementing variable so tell to add to var)
            echo $i
        done
     -  Array loop:
        declare -a users=('bob', 'joe', 'sue')
        echo ${#users[*]} <- count elelmts
        for (( i=0; i<${#users[*]} ; i++)) ; do
            sudo useradd ${users[$i]}
        done
     -  Classic for loop:
        for f in $(ls) ; do stat -c ; done
        for f in $(*) ; do stat -c "%n $F" ; done
     -  continue / break
            continue - ignore current element and prcess to next
            breal - exit the loop
        for file in $(ln) ; do
            if [[ -d $file ]] ; then
                continue
            fi
     -  foreach - only in zsh
        zsh
        foreach f (*) echo $f end
     -  Example:
        https://app.pluralsight.com/course-player?clipId=02414802-b1f5-4e0e-9d73-564e3ac63c4d

        #!/bin/bash
        function create_directory () {
            declare -l directory            <- l ensure that function will be stand alone
            read -p "enter a directory name: " directory
            mkdir $directory
        }

        while true ; do
            clear                           <- this will ensure to clear screen for us
            echo "choose 1 or 2 or 3"
            echo "1 - costam"
            echo "2 - costam"
            echo "3 - exit"
            read -sn1                       <- s to not print anything and n1 to accept only 1 number
            case "$REPLAY" in
                1) who;;
                2) create_directory;;
                3) exit 0;;
            esac
            read -n1 -p "press any key to continue"
        done

# Operationalizing Bash and Z Shell Scripts
# https://app.pluralsight.com/course-player?clipId=b090db89-374b-482d-ad29-1638536cf4ad
    - Awsome script:
    - its all about version (current v4)
    $ bash --version
    $ echo $BASH_VERSION
    CTRL+x CTRL+v
    sudo apt search ^bash$
    - code should be portable
    - Shell option (can be configured using set or shopt:)
    shopt
    shopt <autocd>            <- show specific option
    shopt -s autocd; /etc     <- -s to configure
    shopt restricted_shell    <- only certain operation can be perfomed from shell
    shopt -u autocd           <- -u to unset
    - Option set:
    set -o noclobber          <- -o to enable optionm or:
    set -C 
    set +x noclobber          <- to disable option (or set +C )
    ls /etc/*.conf    
    set -f                    <- to disable globbing for file
    set +f                    <- to enable
    set +od                   <- display options
    - Arithmetic evaluation: let:
    $ type let
    $ let a=3*5
    $ echo $a
    - Expr:
    $ type expr
    $ expr 3 * 5
    15
    $ b=$(expr 3*5)
    $ (( rate < daily_rate )) && echo OK
    - Double Parenthesis:
    $ wcho $(( 3 * 5 ))
    - Arrays:
    (variable that hold many values)
    $ declare -a user_name
    $ user_name[0]=bob ; user_name[1]=smith
    $ echo ${user_name[0]}      <- we use {} delimeter to ensure that system will be not confused  with value
    $ unset user_name ; declare -A user_name
>   - Managing Shell I/O:
    STDOUT - standard output
    STDERR - standard error
    Redirection:
    $ ls /etc/hosts   <- STDOUT
    $ ls /etc/hosts
    $ ls: canno access.. <- STDERR
    $ ls /etc/hosts > file.txt      <- STDOUT
    $ ls /etc/hosts 2> file.txt     <- STDERR
    $ ls /etc/hosts &> file.txt     <- both
    $ ( ls /etc/host ; ls /not/access ) > file.txt    <- redirect block of commands
    $   bash > output.txt <- start new shell + redirect output
    - controlling redirect using exec:
    $ LOG=log.file
    $ exec 4>&1
    $ exec > "$LOG"
    $ ls
    $ exec 1>&4 4>&-
    - HERDOC (ignore)
    $ 'cat > myfile <<END'   <- documment will be filled by us, and end with 'END';
    - Console printing:
        - Quote Variable as they can use spaces 
    $ username='joe smith'
    $ printf "username is: $s\n" $username  <- %s is for string, \n mean neew line
    username is: joe
    username is: smith
    $ printf "username is: $s\n" "$username" <- when you use "" problem not appear, quote variable !
    username is: joe smith
    $ type -a printf <- a show all maches, this will show path to command to check if it is available in shell
    - Process substitution (output from command group can be redirected in the form of process substitution)
    $ cat list1
    $ cat list 2
    $ comm -3 <(sort list1 | uniq) <(sort list2 | uniq) <- comm -3 show only different collumns
    $ man comm (comm is compare command)
    $


    


        













      




