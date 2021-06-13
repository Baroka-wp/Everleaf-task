# README

# App schema
### Model : task

belongs_to:user
has_many:labels

| Colums | Description |
| --- | ----------- |
| user_id | integer |
| label_id | integer |
| task_name | string |
| description | string |
| deadline | date |
| status | string |
| priority | string |



### Model : User

has_many:task

| Colums | Description |
| --- | ----------- |
| name | string |
| email | string |

| password_digest | string |

### Model labels

has_many:tasks
| Colums | Description |
| --- | ----------- |
| user_id | integer |
| name | string |