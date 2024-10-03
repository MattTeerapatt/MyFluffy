CREATE TABLE IF NOT EXISTS ads (
    id SERIAL PRIMARY KEY,
    content VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS charity (
    id SERIAL PRIMARY KEY,
    content VARCHAR(200) NOT NULL
);

INSERT INTO ads (content) VALUES ('Test Ad 1'), ('Test Ad 2')
ON CONFLICT DO NOTHING;
INSERT INTO charity (content) VALUES ('Test Charity 1'), ('Test Charity 2')
ON CONFLICT DO NOTHING;