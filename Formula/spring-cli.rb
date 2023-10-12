# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-10-12T09:37:53.346105238Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.2"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.2/spring-cli-standalone-0.7.2-linux.x86_64.zip"
    sha256 "af089b479630b563dbcc684462d8d4926478811f07ab20059a9cb086fa366c9c"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.2/spring-cli-standalone-0.7.2-osx.x86_64.zip"
    sha256 "20919bbcd5b2310133ec35017700ad7177b22ed8c1ec9e2027c6e7d428641d40"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.2/spring-cli-standalone-0.7.2-osx.x86_64.zip"
    sha256 "20919bbcd5b2310133ec35017700ad7177b22ed8c1ec9e2027c6e7d428641d40"
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
        MachO.codesign!(dylib) if Hardware::CPU.arm?
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/spring --version")
    assert_match "0.7.2", output
  end
end
