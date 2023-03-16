CREATE SCHEMA clinic;

CREATE TABLE patients(
    id INT SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE
);

CREATE TABLE treatments(
    id INT SERIAL PRIMARY KEY,
    type VARCHAR(100),
    name VARCHAR(100)
);

CREATE TABLE medical_histories(
    id INT SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT references patients(id),
    status VARCHAR(100)
);

-- join table between Treatments & Medical Histories
CREATE TABLE medical_histories_has_treatments (
    medical_history_id INT references medical_histories(id),
    treatment_id INT references treatments(id),
);


CREATE TABLE invoices(
    id INT SERIAL PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT references medical_histories(id)
);

CREATE TABLE invoice_items(
    id INT SERIAL PRIMARY KEY,
    unit_price DECIMAL,
    quantity int,
    total_price DECIMAL,
    invoice_id INT  references invoices(id),
    treatment_id INT references treatments(id)
);

-- creating indexes for  foreign keys

CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON invoice_items (treatment_id);
CREATE INDEX ON medical_histories_has_treatments (medical_history_id);
CREATE INDEX ON medical_histories_has_treatments (treatment_id);