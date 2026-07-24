const defaultOrdersApiUrl =
    'https://raw.githubusercontent.com/supreethraj13/order-tracker-api/refs/heads/main/orders.json';

const ordersApiUrl =
    String.fromEnvironment('ORDERS_API_URL', defaultValue: defaultOrdersApiUrl);
