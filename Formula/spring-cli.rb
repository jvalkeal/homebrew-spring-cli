# Generated with JReleaser 1.11.0-SNAPSHOT at 2024-01-29T13:37:59.035156546Z
class SpringCli < Formula
  desc "Spring CLI improves your productivity when creating new Spring projects or adding functionality to existing projects"
  homepage "https://spring.io/projects/spring-cli"
  version "0.8.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.1/spring-cli-standalone-0.8.1-linux.x86_64.zip"
    sha256 "12f3a6cc2853891a9e673401e2384a33f804e6e93a787cdd1866f7fd273700a8"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.1/spring-cli-standalone-0.8.1-osx.aarch64.zip"
    sha256 "f3e6d677ae6e64320d9a8b463f8c35e8e520a829d4568b95b00761dbf8aab227"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.1/spring-cli-standalone-0.8.1-osx.x86_64.zip"
    sha256 "906daba7e0a7d108a9cba59d8083f40bcd141dd7f28f263e7bbcb2cc81bf937f"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
    bash_completion.install Dir["#{libexec}/completion/bash/spring"]
    zsh_completion.install Dir["#{libexec}/completion/zsh/_spring"]
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
    assert_match "0.8.1", output
  end
end
