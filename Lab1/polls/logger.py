import datetime

from polls.models import Record


class SystemLog:
    class __SystemLog:
        def __init__(self, user):
            self.last = user
            self.db_save(user)

        def __str__(self):
            return repr(self) + self.last

        def db_save(self, user):
            r = Record(username=user.username, time=datetime.datetime.now())
            r.save()
    instance = None

    def __init__(self, user):
        if not SystemLog.instance:
            SystemLog.instance = SystemLog.__SystemLog(user)
        else:
            SystemLog.instance.db_save(user)

    def __getattr__(self, name):
        return getattr(self.instance, name)