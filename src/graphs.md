TODO: Motivation.

``` {#fig:test .mermaid caption="Normal setup"}
sequenceDiagram
  participant SEB
  participant LMS
  SEB ->> LMS: GET /exam
  LMS ->> SEB: Exam website
```

``` {#fig:test .mermaid caption="MIMT setup"}
sequenceDiagram
  participant SEB
  participant MIM
  participant LMS
  SEB ->> MIM: GET /exam
  MIM ->> LMS: GET /exam
  LMS ->> MIM: Exam website
  MIM ->> SEB: Modified exam website
```