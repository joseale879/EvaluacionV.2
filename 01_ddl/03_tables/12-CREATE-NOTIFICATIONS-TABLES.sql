
CREATE TABLE notification_type (
    notification_type_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    type_code varchar(30) NOT NULL,
    type_name varchar(100) NOT NULL,
    description text,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uq_notification_type_code UNIQUE (type_code),
    CONSTRAINT uq_notification_type_name UNIQUE (type_name)
);

CREATE TABLE notification (
    notification_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    notification_type_id uuid NOT NULL REFERENCES notification_type(notification_type_id),
    channel varchar(20) NOT NULL,
    subject varchar(200),
    body text NOT NULL,
    status varchar(20) NOT NULL DEFAULT 'PENDING',
    scheduled_at timestamptz,
    sent_at timestamptz,
    error_message text,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_notification_channel CHECK (channel IN ('EMAIL', 'SMS', 'PUSH', 'WHATSAPP')),
    CONSTRAINT ck_notification_status CHECK (status IN ('PENDING', 'SENT', 'FAILED', 'READ'))
);

CREATE TABLE notification_recipient (
    notification_recipient_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    notification_id uuid NOT NULL REFERENCES notification(notification_id) ON DELETE CASCADE,
    person_id uuid REFERENCES person(person_id),
    customer_id uuid REFERENCES customer(customer_id),
    recipient_email varchar(200),
    recipient_phone varchar(20),
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uq_notification_recipient UNIQUE (notification_id, person_id, customer_id),
    CONSTRAINT ck_notification_recipient_one CHECK (
        (person_id IS NOT NULL AND customer_id IS NULL) OR
        (customer_id IS NOT NULL AND person_id IS NULL)
    )
);

CREATE TABLE notification_log (
    notification_log_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    notification_id uuid NOT NULL REFERENCES notification(notification_id) ON DELETE CASCADE,
    action varchar(30) NOT NULL,
    action_at timestamptz NOT NULL DEFAULT now(),
    metadata jsonb,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now()
);