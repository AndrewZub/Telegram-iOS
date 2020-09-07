//
//  SupportSettingsController.swift
//  SettingsUI
//
//  Created by Andrey Zubekhin on 06.09.2020.
//

import Foundation
import UIKit
import ItemListUI
import TelegramPresentationData
import Display
import AccountContext
import SwiftSignalKit
import PresentationDataUtils
import TelegramNotices
import Postbox
import TelegramCore
import UrlHandling

private final class SupportSettingsArguments {
    let openIMeSupport: (String) -> Void
    let openIMeGroup: (String) -> Void
    let openIMeChannel: (String) -> Void
    let openIMeFAQ: (String) -> Void
    let openPrivacyPolicy: (String) -> Void
    let openAskAQuestion: (String) -> Void
    let openFAQ: (String) -> Void
    
    init(openIMeSupport: @escaping (String) -> Void,
         openIMeGroup: @escaping (String) -> Void,
         openIMeChannel: @escaping (String) -> Void,
         openIMeFAQ: @escaping (String) -> Void,
         openPrivacyPolicy: @escaping (String) -> Void,
         openAskAQuestion: @escaping (String) -> Void,
         openFAQ: @escaping (String) -> Void) {
        self.openIMeSupport = openIMeSupport
        self.openIMeGroup = openIMeGroup
        self.openIMeChannel = openIMeChannel
        self.openIMeFAQ = openIMeFAQ
        self.openPrivacyPolicy = openPrivacyPolicy
        self.openAskAQuestion = openAskAQuestion
        self.openFAQ = openFAQ
    }
}

private enum SupportSettingsEntry: ItemListNodeEntry {
    case iMeSupport(PresentationTheme, UIImage?, String, String)
    case iMeGroup(PresentationTheme, UIImage?, String, String)
    case iMeChannel(PresentationTheme, UIImage?, String, String)
    case iMeFAQ(PresentationTheme, UIImage?, String, String)
    case privacyPolicy(PresentationTheme, UIImage?, String, String)
    case askAQuestion(PresentationTheme, UIImage?, String, String)
    case faq(PresentationTheme, UIImage?, String, String)
    
    var section: ItemListSectionId {
        0
    }
    
    var stableId: Int32 {
        switch self {
        case .iMeSupport:
            return 0
        case .iMeGroup:
            return 1
        case .iMeChannel:
            return 2
        case .iMeFAQ:
            return 3
        case .privacyPolicy:
            return 4
        case .askAQuestion:
            return 5
        case .faq:
            return 6
        }
    }
    
    static func ==(lhs: SupportSettingsEntry, rhs: SupportSettingsEntry) -> Bool {
        switch lhs {
        case let .iMeSupport(lhsTheme, lhsImage, lhsText, lhsLink):
            if case let .iMeSupport(rhsTheme, rhsImage, rhsText, rhsLink) = rhs, lhsTheme === rhsTheme, lhsImage === rhsImage, lhsText == rhsText, lhsLink == rhsLink {
                return true
            } else {
                return false
            }
        case let .iMeGroup(lhsTheme, lhsImage, lhsText, lhsLink):
            if case let .iMeGroup(rhsTheme, rhsImage, rhsText, rhsLink) = rhs, lhsTheme === rhsTheme, lhsImage === rhsImage, lhsText == rhsText, lhsLink == rhsLink {
                return true
            } else {
                return false
            }
        case let .iMeChannel(lhsTheme, lhsImage, lhsText, lhsLink):
            if case let .iMeChannel(rhsTheme, rhsImage, rhsText, rhsLink) = rhs, lhsTheme === rhsTheme, lhsImage === rhsImage, lhsText == rhsText, lhsLink == rhsLink {
                return true
            } else {
                return false
            }
        case let .iMeFAQ(lhsTheme, lhsImage, lhsText, lhsLink):
            if case let .iMeFAQ(rhsTheme, rhsImage, rhsText, rhsLink) = rhs, lhsTheme === rhsTheme, lhsImage === rhsImage, lhsText == rhsText, lhsLink == rhsLink {
                return true
            } else {
                return false
            }
        case let .privacyPolicy(lhsTheme, lhsImage, lhsText, lhsLink):
            if case let .privacyPolicy(rhsTheme, rhsImage, rhsText, rhsLink) = rhs, lhsTheme === rhsTheme, lhsImage === rhsImage, lhsText == rhsText, lhsLink == rhsLink {
                return true
            } else {
                return false
            }
        case let .askAQuestion(lhsTheme, lhsImage, lhsText, lhsLink):
            if case let .askAQuestion(rhsTheme, rhsImage, rhsText, rhsLink) = rhs, lhsTheme === rhsTheme, lhsImage === rhsImage, lhsText == rhsText, lhsLink == rhsLink {
                return true
            } else {
                return false
            }
        case let .faq(lhsTheme, lhsImage, lhsText, lhsLink):
            if case let .faq(rhsTheme, rhsImage, rhsText, rhsLink) = rhs, lhsTheme === rhsTheme, lhsImage === rhsImage, lhsText == rhsText, lhsLink == rhsLink {
                return true
            } else {
                return false
            }
        }
    }
    
    static func <(lhs: SupportSettingsEntry, rhs: SupportSettingsEntry) -> Bool {
        return lhs.stableId < rhs.stableId
    }
    
    func item(presentationData: ItemListPresentationData, arguments: Any) -> ListViewItem {
        let arguments = arguments as! SupportSettingsArguments
        switch self {
        case let .iMeSupport(theme, image, text, link):
            return ItemListDisclosureItem(presentationData: presentationData, icon: image, title: text, label: "", sectionId: ItemListSectionId(self.section), style: .blocks, action: {
                arguments.openIMeSupport(link)
            }, clearHighlightAutomatically: false)
        case let .iMeGroup(theme, image, text, link):
            return ItemListDisclosureItem(presentationData: presentationData, icon: image, title: text, label: "", sectionId: ItemListSectionId(self.section), style: .blocks, action: {
                arguments.openIMeGroup(link)
            }, clearHighlightAutomatically: false)
        case let .iMeChannel(theme, image, text, link):
            return ItemListDisclosureItem(presentationData: presentationData, icon: image, title: text, label: "", sectionId: ItemListSectionId(self.section), style: .blocks, action: {
                arguments.openIMeChannel(link)
            }, clearHighlightAutomatically: false)
        case let .iMeFAQ(theme, image, text, link):
            return ItemListDisclosureItem(presentationData: presentationData, icon: image, title: text, label: "", sectionId: ItemListSectionId(self.section), style: .blocks, action: {
                arguments.openIMeFAQ(link)
            }, clearHighlightAutomatically: false)
        case let .privacyPolicy(theme, image, text, link):
            return ItemListDisclosureItem(presentationData: presentationData, icon: image, title: text, label: "", sectionId: ItemListSectionId(self.section), style: .blocks, action: {
                arguments.openPrivacyPolicy(link)
            }, clearHighlightAutomatically: false)
        case let .askAQuestion(theme, image, text, link):
            return ItemListDisclosureItem(presentationData: presentationData, icon: image, title: text, label: "", sectionId: ItemListSectionId(self.section), style: .blocks, action: {
                arguments.openAskAQuestion(link)
            }, clearHighlightAutomatically: false)
        case let .faq(theme, image, text, link):
            return ItemListDisclosureItem(presentationData: presentationData, icon: image, title: text, label: "", sectionId: ItemListSectionId(self.section), style: .blocks, action: {
                arguments.openFAQ(link)
            }, clearHighlightAutomatically: false)
        }
    }
}

private func supportSettingsEntries(presentationData: PresentationData) -> [SupportSettingsEntry] {
    var entries: [SupportSettingsEntry] = []
    let baseLanguageCode = presentationData.strings.baseLanguageCode
    entries.append(.iMeSupport(presentationData.theme,
                               PresentationResourcesSettings.iMeSupport,
                               presentationData.strings.Settings_iMeSupport, "https://t.me/imemessenger"))
    entries.append(.iMeGroup(presentationData.theme,
                             PresentationResourcesSettings.iMeGroup,
                             presentationData.strings.Settings_iMeGroup, "https://t.me/ime_ai"))
    entries.append(.iMeChannel(presentationData.theme,
                               PresentationResourcesSettings.iMeChannel,
                               presentationData.strings.Settings_iMeChannel, baseLanguageCode != "en" ? "https://t.me/ime_ru" : "https://t.me/ime_en"))
    entries.append(.iMeFAQ(presentationData.theme,
                           PresentationResourcesSettings.iMeFAQ,
                           presentationData.strings.Settings_iMeFAQ, baseLanguageCode != "en" ? "https://telegra.ph/iMe-Messenger-FAQ-01-31" : "https://telegra.ph/iMe-Messenger-FAQ-12-25"))
    entries.append(.privacyPolicy(presentationData.theme,
                                  PresentationResourcesSettings.privacyPolicy,
                                  presentationData.strings.Settings_iMePrivacyPolicy, "https://www.imem.app/privacy-policy.html"))
    entries.append(.askAQuestion(presentationData.theme,
                                 PresentationResourcesSettings.support,
                                 presentationData.strings.Settings_Support, "https://telegram.org/faq#general"))
    entries.append(.faq(presentationData.theme,
                        PresentationResourcesSettings.faq,
                        presentationData.strings.Settings_FAQ, "https://telegram.org/faq#general"))
    return entries
}

public func supportSettingsController(context: AccountContext) -> ViewController {

    let contextValue = Promise<AccountContext>()
    var pushControllerImpl: ((ViewController) -> Void)?
    var presentControllerImpl: ((ViewController, Any?) -> Void)?
    var getNavigationControllerImpl: (() -> NavigationController?)?

    let actionsDisposable = DisposableSet()
    var resolveUrlDisposable: MetaDisposable?

    let supportPeerDisposable = MetaDisposable()
    actionsDisposable.add(supportPeerDisposable)

    let open: (String) -> Void = { url in
        let disposable: MetaDisposable
        if let current = resolveUrlDisposable {
            disposable = current
        } else {
            disposable = MetaDisposable()
            resolveUrlDisposable = disposable
        }
        var cancelImpl: (() -> Void)?
        let presentationData = context.sharedContext.currentPresentationData.with { $0 }
        let progressSignal = Signal<Never, NoError> { subscriber in
            let controller = OverlayStatusController(theme: presentationData.theme,  type: .loading(cancelled: {
                cancelImpl?()
            }))
            presentControllerImpl?(controller, nil)

            return ActionDisposable { [weak controller] in
                Queue.mainQueue().async() {
                    controller?.dismiss()
                }
            }
            }
            |> runOn(Queue.mainQueue())
            |> delay(0.15, queue: Queue.mainQueue())
        let progressDisposable = progressSignal.start()
        cancelImpl = {
            resolveUrlDisposable?.set(nil)
        }
        disposable.set((context.sharedContext.resolveUrl(account: context.account, url: url)
            |> afterDisposed {
                Queue.mainQueue().async {
                    progressDisposable.dispose()
                }
            }
            |> deliverOnMainQueue).start(next: { result in
                context.sharedContext.openResolvedUrl(result, context: context, urlContext: .generic, navigationController: getNavigationControllerImpl?(), openPeer: { peer, navigation in
                    context.sharedContext.navigateToChatController(NavigateToChatControllerParams(navigationController: (getNavigationControllerImpl?())!, context: context, chatLocation: .peer(peer), subject: nil, keepStack: .always))
                }, sendFile: nil, sendSticker: nil, present: { _,_ in }, dismissInput: {}, contentContext: nil)
            }))
    }
    let presentationData = context.sharedContext.currentPresentationData.with { $0 }
    
    let openFaq: (Promise<ResolvedUrl>) -> Void = { resolvedUrl in
        let controller = OverlayStatusController(theme: presentationData.theme, type: .loading(cancelled: nil))
        presentControllerImpl?(controller, nil)
        let _ = (resolvedUrl.get()
            |> take(1)
            |> deliverOnMainQueue).start(next: { [weak controller] resolvedUrl in
                controller?.dismiss()
                controller?.dismiss()
                
                context.sharedContext.openResolvedUrl(resolvedUrl, context: context, urlContext: .generic, navigationController: getNavigationControllerImpl?(), openPeer: { peer, navigation in
                }, sendFile: nil, sendSticker: nil, present: { controller, arguments in
                    pushControllerImpl?(controller)
                }, dismissInput: {}, contentContext: nil)
            })
    }
    
    let arguments = SupportSettingsArguments(openIMeSupport: { link in
        open(link)
    }, openIMeGroup: { link in
        open(link)
    }, openIMeChannel: { link in
        open(link)
    }, openIMeFAQ: { link in
        open(link)
    }, openPrivacyPolicy: { link in
        open(link)
    }, openAskAQuestion: { link in
        let resolvedUrl = resolveInstantViewUrl(account: context.account, url: link)
        let resolvedUrlPromise = Promise<ResolvedUrl>()
        resolvedUrlPromise.set(resolvedUrl)
        
        let signal = contextValue.get()
        let supportPeer = Promise<PeerId?>()
        supportPeer.set(supportPeerId(account: context.account))
        let presentationData = context.sharedContext.currentPresentationData.with { $0 }
        
        presentControllerImpl?(textAlertController(context: context, title: nil, text: presentationData.strings.Settings_FAQ_Intro, actions: [
            TextAlertAction(type: .genericAction, title: presentationData.strings.Settings_FAQ_Button, action: {
                openFaq(resolvedUrlPromise)
            }), TextAlertAction(type: .defaultAction, title: presentationData.strings.Common_OK, action: {
                supportPeerDisposable.set((supportPeer.get() |> take(1) |> deliverOnMainQueue).start(next: { peerId in
                    if let peerId = peerId {
                        pushControllerImpl?(context.sharedContext.makeChatController(context: context, chatLocation: .peer(peerId), subject: nil, botStart: nil, mode: .standard(previewing: false)))
                    }
                }))
            })]), nil)
    }, openFAQ: { link in
        let resolvedUrl = resolveInstantViewUrl(account: context.account, url: link)
        let resolvedUrlPromise = Promise<ResolvedUrl>()
        resolvedUrlPromise.set(resolvedUrl)
        openFaq(resolvedUrlPromise)
    })
    let signal = combineLatest(queue: .mainQueue(), context.sharedContext.presentationData, context.sharedContext.accountManager.noticeEntry(key: ApplicationSpecificNotice.secretChatLinkPreviewsKey()))
        |> map { presentationData, noticeView -> (ItemListControllerState, (ItemListNodeState, Any)) in
            var rightNavigationButton: ItemListNavigationButton?
            
            let controllerState = ItemListControllerState(presentationData: ItemListPresentationData(presentationData), title: .text(presentationData.strings.Settings_SupportTitle), leftNavigationButton: nil, rightNavigationButton: rightNavigationButton, backNavigationButton: ItemListBackButton(title: presentationData.strings.Common_Back), animateChanges: false)
            
            let listState = ItemListNodeState(presentationData: ItemListPresentationData(presentationData), entries:
                supportSettingsEntries(presentationData: presentationData), style: .blocks, animateChanges: false)
            
            return (controllerState, (listState, arguments))
    }
    |> afterDisposed {
        actionsDisposable.dispose()
    }

    let controller = ItemListController(context: context, state: signal)
    pushControllerImpl = { [weak controller] value in
        (controller?.navigationController as? NavigationController)?.pushViewController(value, animated: true)
    }
    getNavigationControllerImpl = { [weak controller] in
        return (controller?.navigationController as? NavigationController)
    }
    presentControllerImpl = { [weak controller] value, arguments in
        controller?.present(value, in: .window(.root), with: arguments, blockInteraction: true)
    }

    return controller
}
