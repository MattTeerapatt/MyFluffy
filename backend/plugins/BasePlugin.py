class BasePlugin:
    def register(self, core_system):
        raise NotImplementedError("Plugins must implement the register method")