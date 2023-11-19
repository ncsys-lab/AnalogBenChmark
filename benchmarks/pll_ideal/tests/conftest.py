
import pytest

def pytest_addoption(parser):
    parser.addoption("--plot", action='store_true')


@pytest.fixture(scope='session')
def plot(request):
    value = request.config.option.plot
    return value