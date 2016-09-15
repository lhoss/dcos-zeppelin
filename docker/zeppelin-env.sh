# export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.mesos.coarse=true -Dspark.mesos.executor.home=/opt/spark/dist"
[ -n "${SPARK_MESOS_EXECUTOR_DOCKER_IMAGE}" ] &&
    export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.mesos.executor.docker.image=${SPARK_MESOS_EXECUTOR_DOCKER_IMAGE}"

[ -n "${SPARK_EXECUTOR_MEMORY}" ] &&
    export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.executor.memory=${SPARK_EXECUTOR_MEMORY}"

[ -n "${SPARK_CORES_MAX}" ] &&
    export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.cores.max=${SPARK_CORES_MAX}"

if [ -n "${SPARK_DISPATCHER}" ]; then
    export MASTER=${SPARK_DISPATCHER}
    export SPARK_SUBMIT_OPTIONS="--deploy-mode cluster"
else
    export MASTER=mesos://leader.mesos:5050
fi

export MESOS_NATIVE_LIBRARY=/usr/lib/libmesos.so
