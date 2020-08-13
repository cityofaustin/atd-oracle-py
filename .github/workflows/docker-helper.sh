#!/usr/bin/env bash

# Determine stage
case "${BRANCH_NAME}" in
  "production")
    export WORKING_STAGE="production";
  ;;
  *)
    export WORKING_STAGE="staging";
  ;;
esac

export ATD_IMAGE="atddocker/atd-oracle-py";
#
# We need to assign the name of the branch as the tag to be deployed
#
export ATD_TAG="${WORKING_STAGE}";


function build_container {
    echo "Logging in to Docker hub"
    docker login -u $ATD_DOCKER_USER -p $ATD_DOCKER_PASS

    # First build, tag and push the regular ETL image
    echo "docker build -f Dockerfile -t $ATD_IMAGE:$ATD_TAG .";
    docker build -f Dockerfile -t $ATD_IMAGE:$ATD_TAG .
    # Let's make sure it is tagged and ready to publish
    echo "docker tag $ATD_IMAGE:$ATD_TAG $ATD_IMAGE:$ATD_TAG;";
    docker tag $ATD_IMAGE:$ATD_TAG $ATD_IMAGE:$ATD_TAG;
    # Do publish
    echo "docker push $ATD_IMAGE:$ATD_TAG";
    docker push $ATD_IMAGE:$ATD_TAG;
}