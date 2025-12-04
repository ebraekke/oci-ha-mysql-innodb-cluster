```
┌────────────────────────────────────────────────────────────────────────────┐
│                    RESILIENCE TIER MODEL (VENDOR-NEUTRAL)                  │
└────────────────────────────────────────────────────────────────────────────┘


                         Increasing Resilience  ───────────────►


┌────────────────────────────────────────────────────────────────────────────┐
│ Tier 0 — Single Node                                                       │
│                                                                            │
│  Fault Domain:  One server / instance                                      │
│  Replication:   None                                                       │
│  RPO:           Hours or full data loss                                    │
│  RTO:           Hours                                                      │
│                                                                            │
│  Typical Pattern:                                                          │
│    [ Node ]                                                                │
└────────────────────────────────────────────────────────────────────────────┘


┌────────────────────────────────────────────────────────────────────────────┐
│ Tier 1 — High Availability in One Zone                                     │
│                                                                            │
│  Fault Domain:  One availability zone / datacenter                         │
│  Replication:   Synchronous local (shared disk or shared-nothing)          │
│  RPO:           Zero                                                       │
│  RTO:           Seconds to minutes                                         │
│                                                                            │
│  Typical Pattern:                                                          │
│    [ Node A ] <──sync──> [ Node B ]     (same zone)                        │
└────────────────────────────────────────────────────────────────────────────┘


┌────────────────────────────────────────────────────────────────────────────┐
│ Tier 2 — Metro HA with Synchronous Replication                             │
│                                                                            │
│  Fault Domain:  Two zones in same metro region                             │
│  Replication:   Synchronous metro (low-latency cross-zone)                 │
│  RPO:           Zero                                                       │
│  RTO:           Seconds                                                    │
│                                                                            │
│  Typical Pattern:                                                          │
│        Zone 1                       Zone 2                                 │
│     [ Node A ] <──── synchronous metro replication ────> [ Node B ]        │
│                                                                            │
│  Both zones active or active–passive                                       │
└────────────────────────────────────────────────────────────────────────────┘


┌────────────────────────────────────────────────────────────────────────────┐
│ Tier 3 — Metro HA + Regional DR (Async)                                    │
│                                                                            │
│  Fault Domain:  Metro region + separate geographic region                  │
│  Replication:   Synchronous metro  +  Asynchronous regional                │
│  RPO:           Seconds/minutes (async)                                    │
│  RTO:           Minutes to hours                                           │
│                                                                            │
│  Typical Pattern:                                                          │
│         Metro Zone 1         Metro Zone 2             DR Region            │
│     [ Node A ] <──sync──> [ Node B ]  ─── async ───> [ DR Node ]            │
│                                                                            │
│  Continues operation after zone or region failure                           │
└────────────────────────────────────────────────────────────────────────────┘


                     ────────────────────────────────────────
                     Tiers map directly to business RPO/RTO,
                     regulatory demands (NIS2, DORA),
                     and fault-domain boundaries.
                     ────────────────────────────────────────

```