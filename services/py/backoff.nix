{ lib, buildPythonPackage, fetchFromGitHub, pytestCheckHook, responses, poetry
, pytest-asyncio, }:

buildPythonPackage rec {
  pname = "backoff";
  version = "2.1.2";

  src = fetchFromGitHub {
    owner = "litl";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-eKd1g3UxXlpSlNlik80RKXRaw4mZyvAWl3i2GNuZ3hI=";
  };

  format = "pyproject";

  nativeBuildInputs = [ poetry responses ];

  checkInputs = [ pytestCheckHook pytest-asyncio ];

  meta = with lib; {
    description = "Function decoration for backoff and retry";
    homepage = "https://github.com/litl/backoff";
    license = licenses.mit;
    maintainers = with maintainers; [ chkno ];
  };
}
