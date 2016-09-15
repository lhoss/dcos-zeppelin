# export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.mesos.coarse=true -Dspark.mesos.executor.home=/opt/spark/dist"
[ -n "${SPARK_MESOS_EXECUTOR_DOCKER_IMAGE}" ] &&
    export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.mesos.executor.docker.image=${SPARK_MESOS_EXECUTOR_DOCKER_IMAGE}"

[ -n "${SPARK_EXECUTOR_MEMORY}" ] &&
    export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.executor.memory=${SPARK_EXECUTOR_MEMORY}"

[ -n "${SPARK_CORES_MAX}" ] &&
    export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.cores.max=${SPARK_CORES_MAX}"

# following could be helpful
[ -n "${SPARK_MESOS_EXECUTOR_HOME}" ] &&
    export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.mesos.executor.home=${SPARK_MESOS_EXECUTOR_HOME}"

[ -n "${SPARK_HOME}" ] &&
    export SPARK_HOME="${SPARK_HOME}"

if [ -n "${SPARK_DISPATCHER}" ]; then
    export MASTER=${SPARK_DISPATCHER}
    export SPARK_SUBMIT_OPTIONS="${SPARK_SUBMIT_OPTIONS} --deploy-mode cluster"
else
    export MASTER=${MASTER:-mesos://leader.mesos:5050}
fi

export MESOS_NATIVE_LIBRARY="/usr/lib/libmesos.so"
export MESOS_NATIVE_JAVA_LIBRARY="/usr/lib/libmesos.so"

echo "set MASTER=$MASTER"
echo "set MESOS_NATIVE_LIBRARY=$MESOS_NATIVE_LIBRARY"
echo "set SPARK_SUBMIT_OPTIONS=$SPARK_SUBMIT_OPTIONS"
echo "set SPARK_HOME=$SPARK_HOME"
echo "set ZEPPELIN_JAVA_OPTS=$ZEPPELIN_JAVA_OPTS"
echo "set ZEP_USER:ZEP_GROUP=$ZEP_USER:$ZEP_GROUP"
