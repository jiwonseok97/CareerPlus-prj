import http from "k6/http";
import { check, sleep } from "k6";

export const options = {
  scenarios: {
    main_page: {
      executor: "ramping-vus",
      startVUs: 5,
      stages: [
        { duration: "30s", target: 20 },
        { duration: "60s", target: 50 },
        { duration: "30s", target: 0 },
      ],
      exec: "mainPage",
    },
    company_list: {
      executor: "ramping-vus",
      startVUs: 5,
      stages: [
        { duration: "30s", target: 20 },
        { duration: "60s", target: 40 },
        { duration: "30s", target: 0 },
      ],
      exec: "companyList",
    },
  },
  thresholds: {
    http_req_failed: ["rate<0.01"],
    http_req_duration: ["p(95)<1000"],
  },
};

const BASE_URL = __ENV.BASE_URL || "http://localhost:8081";

export function mainPage() {
  const res = http.get(`${BASE_URL}/careerplus.do`);
  check(res, {
    "main page status 200": (r) => r.status === 200,
  });
  sleep(1);
}

export function companyList() {
  const res = http.get(`${BASE_URL}/companyList.do?selectPageNo=1&rowCntPerPage=20`);
  check(res, {
    "company list status 200": (r) => r.status === 200,
  });
  sleep(1);
}

