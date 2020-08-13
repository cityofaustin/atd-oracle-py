#!/usr/bin/env python3

import cx_Oracle


def main() -> None:
    """
    Runs a sample python script that demonstrates a connection,
    a cursor, SQL execution and closing.
    """

    connection = cx_Oracle.connect(
        "<user>",
        "<pass>",
        "<host>/<service>",
        encoding="UTF-8"
    )

    cursor = connection.cursor()
    cursor.execute(
        """
            select count(*) as total from lu_dept_units
        """
    )

    for total in cursor:
        print(f"Values: {total}")

    cursor.close()
    connection.close()

# Start execution if main
if __name__ == "__main__":
    main()
