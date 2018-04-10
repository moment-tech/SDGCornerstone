/*
 NumericAdditiveArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Tests a type’s conformance to NumericAdditiveArithmetic.
///
/// - Precondition: `augend` is expected to be less than `sum`.
///
/// - Precondition: `augend` is expected to be positive.
@_inlineable public func testNumericAdditiveArithmeticConformance<T>(augend: T, addend: T, sum: T, includingNegatives: Bool, file: StaticString = #file, line: UInt = #line) where T : NumericAdditiveArithmetic {

    testAdditiveArithmeticConformance(augend: augend, addend: addend, sum: sum, file: file, line: line)
    testComparableConformance(less: augend, greater: sum, file: file, line: line)

    test(property: ({ $0.isPositive }, "isPositive"), of: T.additiveIdentity, is: false, file: file, line: line)
    test(property: ({ $0.isPositive }, "isPositive"), of: augend, is: true, file: file, line: line)
    if includingNegatives {
        test(property: ({ $0.isPositive }, "isPositive"), of: T.additiveIdentity − augend, is: false, file: file, line: line)
    }

    test(property: ({ $0.isNegative }, "isNegative"), of: T.additiveIdentity, is: false, file: file, line: line)
    test(property: ({ $0.isNegative }, "isNegative"), of: augend, is: false, file: file, line: line)
    if includingNegatives {
        test(property: ({ $0.isNegative }, "isNegative"), of: T.additiveIdentity − augend, is: true, file: file, line: line)
    }

    test(property: ({ $0.isNonNegative }, "isNonNegative"), of: T.additiveIdentity, is: true, file: file, line: line)
    test(property: ({ $0.isNonNegative }, "isNonNegative"), of: augend, is: true, file: file, line: line)
    if includingNegatives {
        test(property: ({ $0.isNonNegative }, "isNonNegative"), of: T.additiveIdentity − augend, is: false, file: file, line: line)
    }

    test(property: ({ $0.isNonPositive }, "isNonPositive"), of: T.additiveIdentity, is: true, file: file, line: line)
    test(property: ({ $0.isNonPositive }, "isNonPositive"), of: augend, is: false, file: file, line: line)
    if includingNegatives {
        test(property: ({ $0.isNonPositive }, "isNonPositive"), of: T.additiveIdentity − augend, is: true, file: file, line: line)
    }

    test(property: ({ $0.absoluteValue }, "absoluteValue"), of: augend, is: augend, file: file, line: line)
    if includingNegatives {
        test(property: ({ $0.absoluteValue }, "absoluteValue"), of: T.additiveIdentity − augend, is: augend, file: file, line: line)
    }

    test(mutatingMethod: (T.formAbsoluteValue, "formAbsoluteValue"), of: augend, resultsIn: augend, file: file, line: line)
    if includingNegatives {
        test(mutatingMethod: (T.formAbsoluteValue, "formAbsoluteValue"), of: T.additiveIdentity − augend, resultsIn: augend, file: file, line: line)
    }
}