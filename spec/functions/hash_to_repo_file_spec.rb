require 'spec_helper'

describe "the hash_to_repo_file function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    expect(Puppet::Parser::Functions.function("hash_to_repo_file")).to eq("function_hash_to_repo_file")
  end

  it "should raise a ParseError if there is less than 1 arguments" do
    expect { scope.function_hash_to_repo_file([]) }.to( raise_error(Puppet::ParseError))
  end

  it "should return hash keys for files from repos list" do
    repos = { 'repo1' => { 'param1' => 'value1' }, 'repo2' => { 'param2' => 'value2' } }
    result = scope.function_hash_to_repo_file([repos])
    expect(result).to(eq({'/etc/yum.repos.d/repo1.repo' => {}, '/etc/yum.repos.d/repo2.repo' => {}}))
  end

end