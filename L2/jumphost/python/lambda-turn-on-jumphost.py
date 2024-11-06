import os
import boto3

def increase_ASG(asg_name, desired_capacity):
    autoscaling_client = boto3.client('autoscaling')
    response = autoscaling_client.update_auto_scaling_group(
        AutoScalingGroupName=asg_name,
        MinSize=1,
        MaxSize=2,
        DesiredCapacity=desired_capacity
    )
    
    return {
        'statusCode': 200,
        'body': f'The Size of Auto Scaling Group {asg_name} modify to {desired_capacity}.'
    }

def lambda_handler(event, context):
    asg_name = os.environ['ASG_NAME']
    desired_capacity = int(os.environ['DESIRED_CAPACITY'])
    #asg_name= 'shared-services-ci-jumphost-admin-asg'

    try: 
        print("Turn On JumpHosts")
        increase_ASG(asg_name, desired_capacity)
    except Exception as e:
        print(f"Error:{str(e)}")
