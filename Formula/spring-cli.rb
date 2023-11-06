# Generated with JReleaser 1.10.0-SNAPSHOT at 2023-11-06T11:07:04.568909648Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.5"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.5/spring-cli-standalone-0.7.5-linux.x86_64.zip"
    sha256 "c803ff455f4b214ebdd68b95f21f8bd2845caf86cbd3358ca9f74a37401d916a"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.5/spring-cli-standalone-0.7.5-osx.aarch64.zip"
    sha256 "fa9d6fc7399c6236200b095fe7576dbec366c1901bd8136865770d4e7a27ff3f"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.5/spring-cli-standalone-0.7.5-osx.x86_64.zip"
    sha256 "d8353c007f2759966b116c4bf4efaee4d02222215d2dec64045f3e9e6186d53c"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib)
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/spring --version")
    assert_match "0.7.5", output
  end
end
