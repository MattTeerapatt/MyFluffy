class BasePlugin:
    def register(self):
        raise NotImplementedError("Plugins must implement the register method")