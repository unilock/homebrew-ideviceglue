class IdevicerestoreGit < Formula
  desc "Restore/upgrade firmware of iOS devices"
  homepage "https://www.libimobiledevice.org/"
  license "LGPL-3.0-only"
  head "https://git.libimobiledevice.org/idevicerestore.git", branch: "master"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libimobiledevice-glue-git"

  depends_on "curl"
  depends_on "libirecovery-git"
  depends_on "libplist-git"
  depends_on "libzip"

  def install
    system "./autogen.sh", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
