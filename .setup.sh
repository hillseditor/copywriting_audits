#!/bin/sh
os='copyw' # Local container name
cont='copyw'
vol='copyw'
comp=''

adminUser=${copywUSER}
dbname='hillsedit_copywprod'
buscont='no'

sudo ls -a .
./.script/.inc/clone.sh


. ./.script/init.sh

## Remove some config
rm -f vol/ngx/conf.d/{default.conf.rpmnew,defaultdrupal.conf,defaultwordpress.conf,php-fpm.conf.rpmnew}

 
# sudo chown -R ${USER}:${USER}  www/key
# sudo chmod 440 www/key

sleep 3
echo "----- ${comp} ----------"
# 
if [ "$comp" = true ] ; then
    if test -f ./.script/inc/start; then
        filename=`cat filename.txt`
        echo "------------- ${filename} -------------"
        # 
        ./.script/inc/start -v ${vol} -d ${filename} -o ${os}
        # 
        rm -rf tmp

        dock="docker exec -it $cont bash -c"
        ${dock} "chown nginx:nginx /run/php/php8.3-fpm.sock"
        os=${cont}
        
        ./.script/certcp.sh -c ${os}
        docker restart dinitenv

        docker exec -it -u nginx ${os} bash -c "rm -v web/robots.txt; drush user:password ${adminUser} 'admin'"
    fi
fi

filename='filename.txt'
if [ -f "${filename}" ]; then
    rm ${filename}
    echo "$filename is removed"
fi


Step 2: Log in to Docker Hub using the provided token and username
echo  ${TOKENDH} | docker login --username ${USERDH} --password-stdin
docker compose up -d --build
docker logout