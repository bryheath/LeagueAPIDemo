//
//  StatusViewController.swift
//  LeagueAPIDemo
//
//  Created by Antoine Clop on 4/28/19.
//  Copyright © 2019 Antoine Clop. All rights reserved.
//

import UIKit
import LeagueAPI

class StatusViewController: UIViewController {
    
    // MARK: - IBOulet
    
    @IBOutlet weak var statusTitle: UILabel!
    @IBOutlet weak var serviceStatusTableView: UITableView!
    
    // MARK: - Variables
    
    private var statusInfos: ServiceStatus?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusTitle.text = nil
        self.getStatusInfos(region: preferredRegion)
    }
    
    // MARK: - UI
    
    func updateUI(for status: ServiceStatus?) {
        self.statusInfos = status
        self.statusTitle.setText("Server Status for \(status?.name ?? "Unknown")")
        self.serviceStatusTableView.reload()
    }
    
    // MARK: - Functions
    
    func getStatusInfos(region: Region) {
        league.lolAPI.getStatus(on: region) { (status, errorMsg) in
            if let status = status {
                self.updateUI(for: status)
            }
            else {
                print("Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
}

extension StatusViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let statusInfos = self.statusInfos {
            return statusInfos.maintenances.count
            //return statusInfos.services.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let statusInfos = self.statusInfos else { return StatusTableViewCell() }
        let statusAtIndex: Incident = statusInfos.maintenances[indexPath.row]
        //statusInfos.services[indexPath.row]
        //return setupStatusCell(service: statusAtIndex.name, status: statusAtIndex.status)
        // 0 is by usually en_US locale, TODO: make it dynamic based on phone?
        return setupStatusCell(service: statusAtIndex.titles[0].content, status: statusAtIndex.status?.status.description ?? "N/A")
    }
    
    func setupStatusCell(service: String, status: String) -> StatusTableViewCell {
        let newCell: StatusTableViewCell = self.serviceStatusTableView.dequeueReusableCell(withIdentifier: "serviceCell") as! StatusTableViewCell
        newCell.serviceName.setText(service)
        newCell.serviceStatus.setText(status)
        return newCell
    }
}

extension StatusViewController: UITableViewDelegate {
    
}
                               
                               /*
                                {
                                    "id": "OC1",
                                    "name": "Oceania",
                                    "locales": [
                                        "en_AU"
                                    ],
                                    "maintenances": [],
                                    "incidents": [
                                        {
                                            "created_at": "2023-01-19T02:14:10.148483+00:00",
                                            "id": 5818,
                                            "titles": [
                                                {
                                                    "locale": "en_US",
                                                    "content": "Account Transfers Unavailable"
                                                },
                                                {
                                                    "locale": "cs_CZ",
                                                    "content": "Převody účtu nejsou k dispozici"
                                                },
                                                {
                                                    "locale": "de_DE",
                                                    "content": "Kontotransfer nicht verfügbar"
                                                },
                                                {
                                                    "locale": "el_GR",
                                                    "content": "Οι μεταφορές λογαριασμών δεν είναι διαθέσιμες"
                                                },
                                                {
                                                    "locale": "en_AU",
                                                    "content": "Account Transfers Unavailable"
                                                },
                                                {
                                                    "locale": "en_GB",
                                                    "content": "Account Transfers Unavailable"
                                                },
                                                {
                                                    "locale": "es_AR",
                                                    "content": "Transferencias de cuentas no disponibles"
                                                },
                                                {
                                                    "locale": "es_ES",
                                                    "content": "Transferencias de cuentas no disponibles"
                                                },
                                                {
                                                    "locale": "es_MX",
                                                    "content": "Transferencias de cuentas no disponibles"
                                                },
                                                {
                                                    "locale": "fr_FR",
                                                    "content": "Transferts de compte indisponibles"
                                                },
                                                {
                                                    "locale": "hu_HU",
                                                    "content": "A fiókátvitel nem érhető el"
                                                },
                                                {
                                                    "locale": "it_IT",
                                                    "content": "Trasferimenti degli account non disponibili"
                                                },
                                                {
                                                    "locale": "ja_JP",
                                                    "content": "アカウント移行利用不可"
                                                },
                                                {
                                                    "locale": "pl_PL",
                                                    "content": "Transfery kont niedostępne"
                                                },
                                                {
                                                    "locale": "ro_RO",
                                                    "content": "Transferuri de cont indisponibile"
                                                },
                                                {
                                                    "locale": "ru_RU",
                                                    "content": "Перенос учетной записи недоступен"
                                                },
                                                {
                                                    "locale": "tr_TR",
                                                    "content": "Hesap Aktarımları Kullanılamıyor"
                                                }
                                            ],
                                            "maintenance_status": null,
                                            "updated_at": null,
                                            "archive_at": null,
                                            "updates": [
                                                {
                                                    "created_at": "2023-01-19T02:14:10.226109+00:00",
                                                    "id": 9632,
                                                    "translations": [
                                                        {
                                                            "locale": "en_US",
                                                            "content": "Account transfers are currently unavailable while we work on a reported issue."
                                                        },
                                                        {
                                                            "locale": "cs_CZ",
                                                            "content": "Převody účtů jsou dočasně nedostupné, pracujeme na odstranění nahlášeného problému."
                                                        },
                                                        {
                                                            "locale": "de_DE",
                                                            "content": "Kontotransfers sind aktuell nicht verfügbar, während wir einen gemeldeten Fehler beheben."
                                                        },
                                                        {
                                                            "locale": "el_GR",
                                                            "content": "Οι μεταφορές λογαριασμών δεν είναι προσωρινά διαθέσιμες καθώς προσπαθούμε να διορθώσουμε ένα σφάλμα."
                                                        },
                                                        {
                                                            "locale": "en_AU",
                                                            "content": "Account transfers are currently unavailable while we work on a reported issue."
                                                        },
                                                        {
                                                            "locale": "en_GB",
                                                            "content": "Account transfers are currently unavailable while we work on a reported issue."
                                                        },
                                                        {
                                                            "locale": "es_AR",
                                                            "content": "Las transferencias de cuentas no están disponibles por el momento mientras trabajamos para resolver un problema."
                                                        },
                                                        {
                                                            "locale": "es_ES",
                                                            "content": "La transferencia de cuentas no estará disponible mientras trabajamos para solucionar un problema."
                                                        },
                                                        {
                                                            "locale": "es_MX",
                                                            "content": "Las transferencias de cuentas no están disponibles por el momento mientras trabajamos para resolver un problema."
                                                        },
                                                        {
                                                            "locale": "fr_FR",
                                                            "content": "Les transferts de compte sont actuellement indisponibles, nous faisons notre possible pour remédier à ce problème."
                                                        },
                                                        {
                                                            "locale": "hu_HU",
                                                            "content": "A fiókátviteli szolgáltatás jelenleg nem elérhető, amíg egy bejelentett hiba elhárításán dolgozunk."
                                                        },
                                                        {
                                                            "locale": "it_IT",
                                                            "content": "Mentre lavoriamo a una soluzione, il trasferimento degli account sarà momentaneamente inattivo."
                                                        },
                                                        {
                                                            "locale": "ja_JP",
                                                            "content": "報告を受けた問題への修正対応のため、現在アカウント移行は利用できません。"
                                                        },
                                                        {
                                                            "locale": "pl_PL",
                                                            "content": "Transfery kont zostały tymczasowo wyłączone w związku z pracami nad rozwiązaniem zgłoszonego problemu."
                                                        },
                                                        {
                                                            "locale": "ro_RO",
                                                            "content": "Transferurile de cont sunt dezactivate momentan cât timp rezolvăm o problemă raportată de jucători."
                                                        },
                                                        {
                                                            "locale": "ru_RU",
                                                            "content": "Перенести учетную запись на другой сервер пока невозможно. Нам сообщили о проблеме, и мы работаем над ее решением."
                                                        },
                                                        {
                                                            "locale": "tr_TR",
                                                            "content": "Bilinen bir sorun üstünde çalıştığımız için hesap aktarımları şu anda devre dışı."
                                                        }
                                                    ],
                                                    "author": "Riot Games",
                                                    "updated_at": "2023-01-19T02:14:00+00:00",
                                                    "publish": true,
                                                    "publish_locations": [
                                                        "game",
                                                        "riotclient",
                                                        "riotstatus"
                                                    ]
                                                }
                                            ],
                                            "platforms": [
                                                "windows",
                                                "macos"
                                            ],
                                            "incident_severity": "info"
                                        }
                                    ]
                                }
                                */
