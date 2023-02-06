import argparse

class Alert:
    def __init__(self,server,message,severity):
        self.server = server
        self.message = message
        self.severity = severity

    def __repr__(self):
        return repr("Server: " + self.server + " Message: " + self.message + " Severity: " + self.severity) 


# Load some initial Alert data
def load_data():
    alerts = []
    alerts.append(Alert("charlie","ate chocolate","critical"))
    alerts.append(Alert("grandpa","fell out of bed", "critical"))
    alerts.append(Alert("oompa","stubbed toe","critical"))
    alerts.append(Alert("charlie","lost ticket","critical"))
    alerts.append(Alert("oompa","called in sick","warn"))
    alerts.append(Alert("charlie","sang a song","warn"))

    return alerts


# Filter by the given server(s), return the original list if no server is provided
def server_filter(server, alerts):
    filtered = []
    if server != None:
        for alert in alerts:
            if alert.server in server:
                filtered.append(alert)
        return filtered

    return alerts


# Filter by the given severity, return the original list if no severity is provided
def severity_filter(severity, alerts):
    filtered = []
    if severity != None:
        for alert in alerts:
            if alert.severity == severity:
                filtered.append(alert)
        return filtered

    return alerts


# Display all alerts, up to {limit} number of alerts
def display(limit, alerts):
    if limit != None:
        alerts = alerts[:limit]
      
    for alert in alerts:
        print(alert)


def main():
    example_text= '''Examples:

    python3 alert.py -server grandpa
    python3 alert.py -server grandpa -severity critical
    python3 alert.py -server grandpa -server charlie -severity critical
    python3 alert.py -severity warn -limit 1'''

    parser = argparse.ArgumentParser(description="Parse some demo Alert data.",
                                     epilog=example_text,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('-server', help="Filter alerts by the given server. Accepts multiple server flags.", action="append", type=str, default=None)
    parser.add_argument('-severity', help="Filter alerts of the given severity.", type=str, default=None)
    parser.add_argument('-limit', help="Limit the number of alerts displayed to the given value.", type=int, default=None)

    args = parser.parse_args()

    alerts = load_data()
    alerts = server_filter(args.server, alerts)
    alerts = severity_filter(args.severity, alerts)

    display(args.limit, alerts)


if __name__ == "__main__":
    main()
