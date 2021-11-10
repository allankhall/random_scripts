class Alert:
    def __init__(self,server,message,severity):
        self.server = server
        self.message = message
        self.severity = severity

alerts = []
alerts.append(Alert("charlie","ate chocolate","critical"))
alerts.append(Alert("grandpa","fell out of bed", "critical"))
alerts.append(Alert("oompa","stubbed toe","critical"))
alerts.append(Alert("charlie","lost ticket","critical"))
alerts.append(Alert("oompa","called in sick","warn"))
alerts.append(Alert("charlie","sang a song","warn"))
