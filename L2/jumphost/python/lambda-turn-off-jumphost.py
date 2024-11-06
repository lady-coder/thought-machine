import os
import boto3

def check_active_sessions(instance_id):
    ssm_client = boto3.client('ssm')
    response = ssm_client.describe_sessions(
        State='Active',
        Filters=[
            {
                'key': 'Target',
                'value': instance_id
            }
        ]
    )
    
    session_list = response['Sessions']

    return session_list

def get_active_instance_ids_in_ASG(asg_name):
    autoscaling_client = boto3.client('autoscaling')
    
    response = autoscaling_client.describe_auto_scaling_groups(
        AutoScalingGroupNames=[asg_name]
    )
    
    instance_ids = []
    
    if 'AutoScalingGroups' in response:
        instances = response['AutoScalingGroups'][0]['Instances']
        for instance in instances:
            if instance['LifecycleState'] == 'InService':
                instance_ids.append(instance['InstanceId'])
    return instance_ids

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
    all_active_sessions = 0
    ids_in_ASG = get_active_instance_ids_in_ASG(asg_name)
    try: 
        if not ids_in_ASG:
                    print("NO ACTIVES INSTANCE IN ASG")
        else:
            for ids in ids_in_ASG:
                instance_id = ids
                print('instance ID:', instance_id)
                
                try: 
                    active_session = check_active_sessions(instance_id)    
                    if not active_session:
                            print("NO ACTIVES SESSIONS")
                    else:
                        for session in active_session:
                            session_id = session['SessionId']
                            all_active_sessions += 1
                            print('Sessions ID:', session_id)
                except Exception as e:
                    print(f"Error:{str(e)}")
        
        if all_active_sessions == 0:
            decrease_ASG(asg_name)
    
    except Exception as e:
        print(f"Error:{str(e)}")
