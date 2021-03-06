#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

export AMA_NODE="$(hostname)"
pushd $BASEDIR >/dev/null
cd /mesos-dependencies/ && nohup python -m SimpleHTTPServer 8000 &
SERVER_PID=$!



echo "serving amaterasu from /mesos-dependencies on port 8000"
popd >/dev/null

RED=`tput setaf 1`
YELLOW=`tput setaf 3`
NC=`tput sgr0`
bold=$(tput bold)
normal=$(tput sgr0)

#echo ""
#echo ""
#echo "${RED}      (                      )"
#echo "      )\        )      )   ( /(   (   (       )        ("
#echo "     ((${YELLOW}_${RED})(     (     ( ${YELLOW}/${RED}(  )${YELLOW}\(${RED})  )${YELLOW})${RED}\  )(   ( /(  (    )${YELLOW})${RED}\\"
#echo "    )\ ${YELLOW}_${RED} )\    )\  ' )${YELLOW}(_)${RED})(_))/ /(${YELLOW}(_)${RED}(()\  )${YELLOW}(_)${RED}) )\  /((${YELLOW}_${RED})"
#echo "    (_)${NC}_${RED}\(_) ${NC}_${RED}(${YELLOW}(_)${RED}) ((_) _ | |_ (_))   ((_)((_)_ ((_)(_))( ${NC}"
#echo "     / _ \  | '   \()/ _\` ||  _|/ -_) | '_|/ _\` |(_-<| || |"
#echo "    /_/ \_\ |_|_|_|  \__,_| \__|\___| |_|  \__,_|/__/ \_,_|"
#echo ""
#echo "    Continuously deployed data pipelines"
#echo "    Version 0.1.0"
#echo ""
#echo ""

#echo ""
#echo ""
#echo "${bold}      (                      )"
#echo "      )\        )      )   ( /(   (   (       )        ("
#echo "     ((_)(     (     ( /(  )\()  ))\  )(   ( /(  (    ))\\"
#echo "    )\ _ )\    )\  ' )(_))(_))/ /((_)(()\  )(_)) )\  /((_)"
#echo "    (_)_\(_) _((_)) ((_) _ | |_ (_))   ((_)((_)_ ((_)(_))( "
#echo "     / _ \  | '   \()/ _\`||  _|/ -_) | '_|/ _\` |(_-<| || |"
#echo "    /_/ \_\ |_|_|_|  \__,_| \__|\___| |_|  \__,_|/__/ \_,_| ${normal}"
#echo ""
#echo "    Continuously deployed data pipelines"
#echo "    Version 0.1.0"
#echo ""
#echo ""
#
echo ""
echo ""
echo "${bold}${RED}                                             /\ "
echo "  				            /  \ /\ "
echo "  				           / ${YELLOW}/\\${RED} /  \ "
echo "      ${NC}${bold}_                 _               ${RED}  / ${YELLOW}/${RED}  / ${YELLOW}/\\${RED} \ ${NC}"
echo "${bold}     /_\   _ __   __ _ | |_  ___  _ _  __${RED}(${NC}${bold}_${YELLOW}( ${NC}${bold}_${RED}(${NC}${bold}_${YELLOW}(${NC}${bold}_ ${YELLOW})${NC}${bold}_${RED})${NC}${bold} "
echo "    / _ \ | '  \ / _\` ||  _|/ -_)| '_|/ _\` |(_-<| || | "
echo "   /_/ \_\|_|_|_|\__,_| \__|\___||_|  \__,_|/__/ \_,_| "
echo ""
echo "    Continuously deployed data pipelines"
echo "    Version 0.1.0"
echo "${NC}"
echo ""

for i in "$@"
do
case $i in
    -r=*|--repo=*)
    REPO="${i#*=}"
    shift # past argument=value
    ;;
    -b=*|--branch=*)
    BRANCH="${i#*=}"
    shift # past argument=value
    ;;
    -e=*|--env=*)
    ENV="${i#*=}"
    shift # past argument=value
    ;;
    -n=*|--name=*)
    NAME="${i#*=}"
    shift # past argument=value
    ;;
    -i=*|--job-id=*)
    JOBID="${i#*=}"
    shift # past argument=value
    ;;
    -i=*|--report=*)
    REPORT="${i#*=}"
    shift # past argument=value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument with no value
    ;;
    *)
            # unknown option
    ;;
esac
done

echo "repo: ${REPO} "
CMD="java -cp ${BASEDIR}/amaterasu-assembly-0.1.0.jar -Djava.library.path=/usr/lib io.shinto.amaterasu.mesos.JobLauncher" #--repo "https://github.com/roadan/amaterasu-job-sample.git" --branch master

if [ -n "$REPO" ]; then
    CMD+=" --repo ${REPO}"
fi

if [ -n "$BRANCH" ]; then
    CMD+=" --branch ${BRANCH}"
fi

if [ -n "$ENV" ]; then
    CMD+=" --env ${ENV}"
fi

if [ -n "$NAME" ]; then
    CMD+=" --name ${NAME}"
fi

if [ -n "$JOBID" ]; then
    CMD+=" --job-id ${JOBID}"
fi

if [ -n "$REPORT" ]; then
    CMD+=" --report ${REPORT}"
fi

echo $CMD

eval $CMD | grep "===>\|*"
kill $SERVER_PID

echo ""
echo ""
echo "W00t amaterasu job is finished!!!"
