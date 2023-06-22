from enum import Enum

class InsightSeverity(Enum):
    LOW = "Low"
    MEDIUM = "Medium"
    HIGH = "High"
    CRITICAL = "Critical"
    HEALTHY = "Healthy"
    NA = "N/A"

class InsightStatus(Enum):
    INFO = "Info"
    SKIPPED = "Skipped"
    FAILED = "Failed"
    HEALTHY = "Healthy"

class OpenInsight:
    def __init__(self, name, ID, category, status, context, severity=InsightSeverity.HEALTHY,  impact = None, remediation_plan=None):
        self.name = name
        self.ID = ID
        self.category = category
        self.status = status
        self.severity = severity
        self.context = context
        self.impact = impact
        self.remediation_plan = remediation_plan
