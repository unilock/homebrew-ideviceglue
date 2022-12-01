class LibusbmuxdGit < Formula
  desc "USB multiplexor library for iOS devices"
  homepage "https://www.libimobiledevice.org/"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later"]

  head "https://git.libimobiledevice.org/libusbmuxd.git", branch: "master"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libusb"

  depends_on "libimobiledevice-glue-git"
  depends_on "libplist-git"

  uses_from_macos "netcat" => :test

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    source = free_port
    dest = free_port
    fork do
      exec bin/"iproxy", "-s", "localhost", "#{source}:#{dest}"
    end

    sleep(2)
    system "nc", "-z", "localhost", source
  end
end
