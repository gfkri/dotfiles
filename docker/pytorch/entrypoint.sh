#!/bin/bash
set -e

LOCAL_UID=${LOCAL_UID:-$(id -u "${USERNAME}")}
LOCAL_GID=${LOCAL_GID:-$(id -g "${USERNAME}")}

if [ "$LOCAL_UID" != "$(id -u "${USERNAME}")" ]; then
    usermod -u "$LOCAL_UID" "${USERNAME}"
fi
if [ "$LOCAL_GID" != "$(id -g "${USERNAME}")" ]; then
    if getent group "$LOCAL_GID" > /dev/null 2>&1; then
        usermod -g "$LOCAL_GID" "${USERNAME}"
    else
        groupmod -g "$LOCAL_GID" "${USERNAME}"
    fi
fi

export HOME="/home/${USERNAME}"
cd "${HOME}"
exec gosu "${USERNAME}" "$@"
