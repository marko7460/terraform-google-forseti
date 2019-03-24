/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "random_string" "pubsub-topic-suffix" {
  lower   = "true"
  upper   = "false"
  special = "false"
  length  = 4
}

// Requires `roles/pubsub.admin` on `pubsub_project_id`
resource "google_pubsub_topic" "main" {
  project = "${var.pubsub_project_id}"
  name    = "real-time-enforcer-sinks-test-topic-${random_string.pubsub-topic-suffix.result}"
}

module "real_time_enforcer_organization_sink" {
  source = "../../../modules/real_time_enforcer_organization_sink"

  pubsub_project_id = "${var.pubsub_project_id}"
  org_id            = "${var.org_id}"
  enforcer_topic    = "${google_pubsub_topic.main.name}"
}
