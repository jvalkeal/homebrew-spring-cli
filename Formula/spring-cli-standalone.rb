# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-10-11T16:07:08.619102855Z
class SpringCliStandalone < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/spring-cli-standalone-0.7.1-linux.x86_64.zip"
    sha256 "f1c3f235c8a0e628c9b13d68853840fb86f230a990063f22b556df75eb3d3dbf"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring-cli-standalone" => "spring-cli-standalone"
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib) if Hardware::CPU.arm?
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/spring-cli-standalone --version")
    assert_match "0.7.1", output
  end
end
