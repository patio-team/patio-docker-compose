#!/usr/bin/env bash

if [ "$DWBH_DEFAULT_USER_ENABLED" = "true" ]; then
    SQL="INSERT INTO users (id, name, email, password, otp) VALUES ('6a489acc-5e10-11e9-8647-d663bd873d93','Default', '$DWBH_DEFAULT_USER_USERNAME', '$DWBH_DEFAULT_USER_PASSWORD', '');"
    FINISHED=false

    while [ "$FINISHED" = "false" ]; do
        echo "Trying to set default user... $DWBH_DEFAULT_USER_USERNAME"

        # if sql is executed the while-loop will end
        psql -U $DWBH_JDBC_USER dwbh -c "$SQL" && FINISHED=true

        echo "Waiting 5 seconds..."
        sleep 5
    done

    echo "Finishing adding default user $DWBH_DEFAULT_USER_USERNAME"
fi
