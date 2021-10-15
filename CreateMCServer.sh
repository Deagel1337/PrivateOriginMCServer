#!/bin/bash

# Check for required files
echo "Checking for required files"
if [[ ! -f ./fabric_api.jar || ! -f ./mcdata/mods/fabric_api.jar ]]; then
    curl -o fabric_api.jar https://media.forgecdn.net/files/3486/63/fabric-api-0.40.8%2B1.17.jar
    echo "Downloaded fabric_api"
fi
if [[ ! -f ./origin.jar || ! -f ./mcdata/mods/fabric_api.jar ]]; then
    curl -o origin.jar https://media.forgecdn.net/files/3488/415/Origins-1.17-1.1.2.jar
    echo "Downloaded origin"
fi
if [[ ! -f ./origin_extras.jar || ! -f ./mcdata/mods/fabric_api.jar ]]; then
    curl -o origin_extras.jar https://media.forgecdn.net/files/3489/452/extraorigins-1.17-9.jar
    echo "Downloaded origin_extras"
fi
if [[ ! -f ./pehkui.jar || ! -f ./mcdata/mods/pehkui.jar ]]; then
    curl -o pehkui.jar https://media.forgecdn.net/files/3457/608/Pehkui-2.4.0%2B1.14.4-1.17.1.jar
    echo "Downloaded origin_extras"
fi
# Starting mc server to generate volume folder
docker-compose up -d

until [ -d "./mcdata/mods" ]
do
    if [[ ! -d "./mcdata/mods" ]]; then
        echo "Waiting 30s for folder..."
        sleep 30
    fi
done

# Moving files to mods folder 
if [[ -d "./mcdata/mods" ]]; then
    mv fabric_api.jar ./mcdata/mods/
    mv origin.jar ./mcdata/mods/
    mv origin_extras.jar ./mcdata/mods/
    mv pehkui.jar ./mcdata/mods/
    echo "Moved files to folder"
fi

docker-compose down
docker-compose up -d

echo "Started container"