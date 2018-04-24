load "#{File.dirname(__FILE__)}../scripts/aws_code_deploy_deployment_check"

describe AWS::CodeshipCodeDeployCheck do
  let(:deployment_id){ random_string }
  let(:deployment_file_path){ random_string }
  let(:create_deployment_info){ {deploymentId: deployment_id}.to_json }
  let(:codeship_code_deploy_check){ AWS::CodeshipCodeDeployCheck.new(deployment_file_path) }

  before :each do
    allow(File).to receive(:read).and_return(create_deployment_info)
  end

  it 'loads the deployment_id out of the specified file' do
    allow(Open3).to receive(:capture3).and_return(deployment_info)
    expect(File).to receive(:read).with(deployment_file_path).and_return(create_deployment_info)
    expect(codeship_code_deploy_check.check_deployment).to be true
  end

  it 'executes CodeDeploy get-deployment to get results' do
    allow(Open3).to receive(:capture3).with("codeship_aws deploy get-deployment --deployment-id #{deployment_id}").and_return(deployment_info)
    expect(codeship_code_deploy_check.check_deployment).to be true
  end

  it 'retries aws if the deployment doesnt succeed' do
    allow(Open3).to receive(:capture3).twice.with("codeship_aws deploy get-deployment --deployment-id #{deployment_id}").and_return(deployment_info(random_string), deployment_info)
    expect(codeship_code_deploy_check).to receive(:sleep).with(3)
    expect(codeship_code_deploy_check.check_deployment).to be true
  end

  it 'fails for all failure statuses' do
    ['Aborted', 'Failed'].each do |status|
      allow(Open3).to receive(:capture3).and_return(deployment_info(status))
      expect(codeship_code_deploy_check.check_deployment).to be false
    end
  end

  it 'fails on Exception' do
    allow(Open3).to receive(:capture3).and_raise(Exception)
    expect(codeship_code_deploy_check.check_deployment).to be false
  end

  it 'fails if external aws command fails' do
    allow(Open3).to receive(:capture3).and_return(["", "", 1])
    expect(codeship_code_deploy_check.check_deployment).to be false
  end

  def deployment_info status='Succeeded'
    [{ 'deploymentInfo' => { 'status' => status } }.to_json, "", 0]
  end
end
