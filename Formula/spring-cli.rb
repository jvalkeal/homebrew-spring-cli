# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-10-31T19:12:40.954625769Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.4"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.4/spring-cli-standalone-0.7.4-linux.x86_64.zip"
    sha256 "2fcee2ac003655d0dd1452fcf8c03184309c58d3b915569a0b41543b84daff15"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.4/spring-cli-standalone-0.7.4-osx.aarch64.zip"
    sha256 "a62133c699da1a806ad80999deecadcbf42c9f9ba19e4841f5ee2679b3a7e918"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.4/spring-cli-standalone-0.7.4-osx.x86_64.zip"
    sha256 "f2cdbc9ad4c98d9566035993e6a0481934e48c7c57ad29bbf8b89e42d1a873db"
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
    assert_match "0.7.4", output
  end
end
