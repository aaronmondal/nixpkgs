{ lib
, pycryptodome
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "cart";
  version = "1.2.1";
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "CybercentreCanada";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-PsdDlNhX0FbuwS5ZXk9P98DjnzDGdigfnRwrdwYa4qY=";
  };

  propagatedBuildInputs = [
    pycryptodome
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pytestFlagsArray = [
    "unittests"
  ];

  pythonImportsCheck = [
    "cart"
  ];

  meta = with lib; {
    description = "Python module for the CaRT Neutering format";
    homepage = "https://github.com/CybercentreCanada/cart";
    changelog = "https://github.com/CybercentreCanada/cart/releases/tag/v${version}";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
