import pytest
import requests
from helloworld import responseconcat

def test_method1():
    response = responseconcat("test")
    assert type(response) == str

# def test_method2():
#     req = requests.get("http://localhost:3000")
#     assert req.status_code == 200


