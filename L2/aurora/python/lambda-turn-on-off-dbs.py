import boto3
import os
rds = boto3.client('rds')

state_to_check=''

def lambda_handler(event, context):
    state_tag= os.environ['STATE_TAG']
    if state_tag == 'blx:autostop':
        state_to_check = 'available'
    elif state_tag == 'blx:autostart':
        state_to_check = 'stopped'

    #Stop DB clusters
    dbs = rds.describe_db_clusters()
    for db in dbs['DBClusters']:
        #Check if DB cluster started. Stop it if eligible.
        if (db['Status'] == state_to_check):
            doNotStop=1
            try:
                GetTags=rds.list_tags_for_resource(ResourceName=db['DBClusterArn'])['TagList']
                for tags in GetTags:
                #if tag "autostop=yes" is set for cluster, stop it
                    if(tags['Key'] == state_tag and tags['Value'] == 'yes'):
                        if state_tag == 'blx:autostop':
                            result = rds.stop_db_cluster(DBClusterIdentifier=db['DBClusterIdentifier'])
                            print ("Stopping cluster: {0}.".format(db['DBClusterIdentifier']))
                        else:
                            result = rds.start_db_cluster(DBClusterIdentifier=db['DBClusterIdentifier'])
                            print ("Starting cluster: {0}.".format(db['DBClusterIdentifier']))                                
                if(doNotStop == 1):
                    doNotStop=1
            except Exception as e:
                print ("Cannot stop cluster {0}.".format(db['DBClusterIdentifier']))
                print(e)
                

if __name__ == "__main__":
    lambda_handler(None, None)