// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <iostream>
#include <openssl/crypto.h>
#include <openssl/ssl.h>
#include <boost/version.hpp>
#include <mysql/mysql.h>
#include <zlib.h>
#include <bzlib.h>
#include <recast/Recast/Recast.h>
#include <recast/Detour/DetourNavMesh.h>
#include "revision.h"

int main()
{
  std::cout << OPENSSL_VERSION_TEXT << "(Library: " << SSLeay_version(SSLEAY_VERSION) << ")" <<"\n";
  std::cout << "Using Boost: " << BOOST_LIB_VERSION <<"\n";
  std::cout << "Using MySQL: " << LIBMYSQL_VERSION << "\n";
  std::cout << "Using ZLib: " << ZLIB_VERSION << "\n";

  std::cout << "Git revision: " << REVISION_ID << "\n";
  std::cout << "Project built: " << REVISION_DATE << "\n";
  std::cout << "Project version: " << VERSION << "\n";

#ifdef  BZ_OK
  std::cout << "BZip2 is detected" << "\n";
#else
  std::cout << "BZip2 is not found!" << "\n";
#endif //  BZ_OK
  return 0;
}
