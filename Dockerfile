FROM mongo:5

COPY *.js /docker-entrypoint-initdb.d/

LABEL "com.datadoghq.ad.check_names"='["mongo"]'
LABEL "com.datadoghq.ad.init_configs"='[{}]'
LABEL "com.datadoghq.ad.instances"='[{"hosts": ["%%host%%:%%port%%"], "username": "datadog", "password" : "<UNIQUEPASSWORD>", "database": "<DATABASE>"}]'
LABEL "com.datadoghq.ad.logs"='[{"source":"mongodb","service":"<SERVICE_NAME>"}]'

COPY user.js /tmp/
RUN mongo < /tmp/user.js
