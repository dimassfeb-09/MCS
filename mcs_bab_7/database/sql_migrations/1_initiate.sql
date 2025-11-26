-- +migrate Up
-- +migrate StatementBegin

CREATE TABLE servo(
    id INTEGER PRIMARY KEY,
    srv_status INTEGER
);

-- +migrate StatementEnd