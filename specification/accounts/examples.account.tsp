import "./models.account.tsp";

namespace MoovAPI;

const ExampleCreateIndividualAccount: CreateAccount = #{
  accountType: AccountType.individual,
  profile: #{
    individual: #{ name: #{ firstName: "Jordan", lastName: "Lee" } },
  },
};

const ExampleIndividualAccount: Account = #{
  mode: Mode.sandbox,
  accountID: "20bcb33d-8cae-4411-aec2-eca0d252137b",
  accountType: AccountType.individual,
  displayName: "Jordan Lee",
  profile: #{
    individual: #{ name: #{ firstName: "Jordan", lastName: "Lee" } },
  },
  verification: #{
    verificationStatus: AccountVerificationStatus.unverified,
    status: VerificationStatus.unverified,
  },
  createdOn: utcDateTime.fromISO("2024-12-16T17:52:14.219311143Z"),
  updatedOn: utcDateTime.fromISO("2024-12-16T17:52:14.219311143Z"),
};

const ExampleCreateBusinessAccount: CreateAccount = #{
  accountType: AccountType.business,
  profile: #{ business: #{ legalBusinessName: "Whole Body Fitness LLC" } },
};

const ExampleBusinessAccount: Account = #{
  mode: Mode.sandbox,
  accountID: "53ca67ea-6fd3-423f-9544-ce2404159d33",
  accountType: AccountType.business,
  displayName: "Whole Body Fitness LLC",
  profile: #{
    business: #{
      legalBusinessName: "Whole Body Fitness LLC",
      ownersProvided: false,
    },
  },
  verification: #{
    verificationStatus: AccountVerificationStatus.unverified,
    status: VerificationStatus.unverified,
  },
  settings: #{
    cardPayment: #{ statementDescriptor: "Whole Body Fitness LLC" },
    achPayment: #{ companyName: "Whole Body Fitne" },
  },
  createdOn: utcDateTime.fromISO("2024-12-16T17:55:20.557151867Z"),
  updatedOn: utcDateTime.fromISO("2024-12-16T17:55:20.557151867Z"),
};
