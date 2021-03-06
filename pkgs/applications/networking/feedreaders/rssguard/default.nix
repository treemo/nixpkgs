{ stdenv, fetchFromGitHub, qmake, qtwebengine, qttools, wrapGAppsHook }:

stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "rssguard";
  version = "3.5.5";

  src = fetchFromGitHub {
    owner = "martinrotter";
    repo = pname;
    rev = version;
    sha256 = "0swjh664y1yqr1rn3ym2kicyx7r97ypr4qf7qrjl4a5q1spzsv48";
  };

  buildInputs =  [ qtwebengine qttools ];
  nativeBuildInputs = [ qmake wrapGAppsHook ];
  qmakeFlags = [ "CONFIG+=release" ];

  # FIXME: This shouldn't be needed after 3.5.5.
  # See: https://github.com/martinrotter/rssguard/issues/175
  preConfigure = ''
    lrelease rssguard.pro
  '';

  meta = with stdenv.lib; {
    description = "Simple RSS/Atom feed reader with online synchronization";
    longDescription = ''
      RSS Guard is a simple, light and easy-to-use RSS/ATOM feed aggregator
      developed using Qt framework and with online feed synchronization support
      for ownCloud/Nextcloud.
    '';
    homepage = https://github.com/martinrotter/rssguard;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ jluttine ];
  };
}
