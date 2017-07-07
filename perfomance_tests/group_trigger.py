from hawkular.alerts import Trigger, TriggerMode, HawkularAlertsClient, ConditionType, Operator, Condition, GroupConditionsInfo
from hawkular.client import HawkularMetricsConnectionError
from locust import HttpLocust, TaskSet, task
import random

# This is just a Dummy Client - The call won't be through client
base = HawkularAlertsClient(tenant_id='dummy')
trigger_id = ''

class GroupTriggerBehavior(TaskSet):
    def on_start(self):
        self.random_value = str(random.randint(0,9999))
        self.trigger_id = "MIQ-#" + self.random_value
        self.test_hawkular_status

    def test_hawkular_status(self):
        with self.client.get(url=base._get_status_url(),  catch_response=True) as response:
             if response.data == "fail":
                raise ResponseError("Hawkular is off")

    def initialize_sample_group_condition(self):
        condition1 = Condition()
        condition1.trigger_mode = TriggerMode.FIRING
        condition1.type = ConditionType.COMPARE
        condition1.data_id = 'mw_heap_used'
        condition1.threshold = 10
        condition1.operator = Operator.GT


        condition2 = Condition()
        condition2.trigger_mode = TriggerMode.FIRING
        condition2.type = ConditionType.COMPARE
        condition2.data_id = 'mw_heap_used'
        condition2.threshold = 100
        condition2.operator = Operator.LT

        gc = GroupConditionsInfo()
        gc.addCondition(condition1)
        gc.addCondition(condition2)

        return base._serialize_object(gc)


    def initialize_sample_group_trigger(self):
        trigger =  Trigger()
        trigger.id = self.trigger_id
        trigger.name =  'WildFly Memory Metrics~Heap Used'
        trigger.event_text = "ManageIQ Triggered"
        trigger.contex = { 'dataId.hm.type' : 'gauge', 'dataId.hm.prefix' : 'hm_g_' }
        trigger.tags = {'miq.event_type': 'hawkular-alert', 'miq.resource_type': 'miq_alert'}
        trigger.enabled = True

        # Converting from Hawkular Client to a Simple JSON
        return base._serialize_object(trigger)


    @task(1)
    def create_group_trigger(self):

        headers = {
            'authorization': "Basic amRvZTpwYXNzd29yZA==",
            'content-type': "application/json"
        }
        headers['hawkular-tenant'] = "hawkular-client -" + self.random_value

        group_trigger =self.initialize_sample_group_trigger()


        # Send the Post Request (Group Trigger)
        with  self.client.post(url=base._service_url(['triggers', 'groups']),
        data=group_trigger, headers=headers,  catch_response=True) as response:
             if response.status_code == 400:
                print(response.content)

    @task(1)
    def create_group_conditions(self):
       headers = {
            'authorization': "Basic amRvZTpwYXNzd29yZA==",
            'content-type': "application/json"
        }
       headers['hawkular-tenant'] = "hawkular-client -" +self.random_value
       group_conditions =  self.initialize_sample_group_condition()


       with self.client.put(url=base._service_url(['triggers', 'groups', self.trigger_id, 'conditions', TriggerMode.FIRING]),
       data=group_conditions, headers=headers,  catch_response=True) as response:
             if response.status_code == 400:
                print(response.content)


class HawkularUser(HttpLocust):
    task_set =  GroupTriggerBehavior
