import os
import boto3

def increase_ASG(asg_name, desired_capacity):
    autoscaling_client = boto3.client('autoscaling')
    response = autoscaling_client.update_auto_scaling_group(
        AutoScalingGroupName=asg_name,
        MinSize=1,
        DesiredCapacity=desired_capacity
    )
    
    return {
        'statusCode': 200,
        'body': f'The Size of Auto Scaling Group {asg_name} modify to {desired_capacity}.'
    }

def decrease_ASG(asg_name):
    autoscaling_client = boto3.client('autoscaling')
    desired_capacity = 0

    response = autoscaling_client.update_auto_scaling_group(
        AutoScalingGroupName=asg_name,
        MinSize=0,
        DesiredCapacity=desired_capacity
    )
    
    return {
        'statusCode': 200,
        'body': f'The Size of Auto Scaling Group {asg_name} modify to {desired_capacity}.'
    }



def lambda_handler(event, context):
    asg_name = os.environ['ASG_NAME']
    desired_capacity = int(os.environ['DESIRED_CAPACITY'])
    state_tag= os.environ['STATE_TAG']

    try: 
        if state_tag == 'start':
            print("Turn On Spacelift Workers")
            increase_ASG(asg_name, desired_capacity)
        elif state_tag == 'stop':
            print("Turn Off Spacelift Workers")
            decrease_ASG(asg_name)
    except Exception as e:
        print(f"Error:{str(e)}")
