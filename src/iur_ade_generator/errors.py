"""The exception the generators raise for invalid input, configuration and failed tools."""


class GeneratorError(Exception):
    """Reported to the user as a message without a traceback."""
