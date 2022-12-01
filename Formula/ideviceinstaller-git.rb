class IdeviceinstallerGit < Formula
  desc "Tool for managing apps on iOS devices"
  homepage "https://www.libimobiledevice.org/"
  license "GPL-2.0-or-later"
  head "https://git.libimobiledevice.org/ideviceinstaller.git", branch: "master"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libzip"

  depends_on "libimobiledevice-git"
  depends_on "libplist-git"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/ideviceinstaller --help |grep -q ^Usage"
  end
end
